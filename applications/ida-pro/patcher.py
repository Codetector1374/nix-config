# This work is free. You can redistribute it and/or modify it under the
# terms of the Do What The Fuck You Want To Public License, Version 2,
# as published by Sam Hocevar. See http://www.wtfpl.net/ for more details.
import json
import hashlib
import os
import argparse
import shutil
from datetime import datetime, timedelta
import sys


def json_stringify_alphabetical(obj: dict):
    return json.dumps(obj, sort_keys=True, separators=(",", ":"))


def buf_to_bigint(buf: bytes):
    return int.from_bytes(buf, byteorder="little")


def bigint_to_buf(i: int):
    return i.to_bytes((i.bit_length() + 7) // 8, byteorder="little")


class RSA:
    def __init__(self):
        self.hexrays_modulus_bytes = bytes.fromhex(
            "edfd425cf978546e8911225884436c57140525650bcf6ebfe80edbc5fb1de68f4c66c29cb22eb668788afcb0abbb718044584b810f8970cddf227385f75d5dddd91d4f18937a08aa83b28c49d12dc92e7505bb38809e91bd0fbd2f2e6ab1d2e33c0c55d5bddd478ee8bf845fcef3c82b9d2929ecb71f4d1b3db96e3a8e7aaf93"
        )
        self.hexrays_modulus = buf_to_bigint(self.hexrays_modulus_bytes)

        self.patched_modulus_bytes = bytearray(self.hexrays_modulus_bytes)
        self.patched_modulus_bytes[17] ^= 1 << 4 # peak of the golfing! only 1 bit changed
        # if you want the old patched modulus, comment the line above and uncomment the line below
        # self.patched_modulus_bytes[3] = 0xcb

        self.patched_modulus = buf_to_bigint(self.patched_modulus_bytes)
        self.exponent = 0x13
        # Small update: A lot of people were curious how was the private key generated, so let me explain.
        # You know how RSA works, right?
        # The private key usually consists of two or more prime numbers, and the public key is the product of those prime numbers.
        # p - prime number 1
        # q - prime number 2
        # n = p * q - public modulus
        # e - public exponent
        # They are being used to compute a private exponent d, which in this case is used to sign the payload.
        # d = e^-1 mod (p-1)(q-1)
        # Did you see what exactly was done to the public modulus?
        # It's a prime number! But RSA is usually used with two prime numbers, right?
        # And the only reason RSA is secure is because we assume that it's very hard to find the factors of a public modulus.
        # And if n is a prime number, then the only factor is n - which means - RSA essentially becomes a symmetric cipher.
        # So how do we get the private key? It's simple: d = e^-1 mod (n-1)
        # ~ alula
        self.private_key = pow(self.exponent, -1, self.patched_modulus - 1)
        # print("private_key:", bigint_to_buf(private_key).hex())

    def decrypt(self, message: bytes):
        decrypted = pow(buf_to_bigint(message), self.exponent, self.patched_modulus)
        decrypted = bigint_to_buf(decrypted)
        return decrypted[::-1]

    def encrypt(self, message: bytes):
        encrypted = pow(
            buf_to_bigint(message[::-1]), self.private_key, self.patched_modulus
        )
        encrypted = bigint_to_buf(encrypted)
        return encrypted


def patch_ida_files(apply=False):
    """Patch all IDA files"""
    files_to_patch = [
        "libida32.so",
        "libida.so",
    ]

    success_count = 0
    for filename in files_to_patch:
        if generate_patched_dll(filename, apply):
            success_count += 1

    return success_count


rsa = RSA()


def generate_patched_dll(filename, apply=False):
    if not os.path.exists(filename):
        # print(f"Didn't find {filename}, skipping patch generation")
        return False

    with open(filename, "rb") as f:
        data = f.read()

        if data.find(rsa.patched_modulus_bytes) != -1:
            print(f"{filename} looks to be already patched :)")
            return True

        if data.find(rsa.hexrays_modulus_bytes) == -1:
            print(f"{filename} doesn't contain the original modulus.")
            return False

        data = data.replace(
            rsa.hexrays_modulus_bytes, rsa.patched_modulus_bytes
        )

        patched_filename = f"{filename}.patched"
        with open(patched_filename, "wb") as f:
            f.write(data)

        print(f"Generated patch: {patched_filename}")

    if apply:
        # Check if file is writable
        try:
            with open(filename, "r+b"):
                pass
        except Exception:
            print(f"Error: {filename} is not writable. Cannot swap files.")
            return False

        backup_filename = f"{filename}.bak"
        try:
            if not os.path.exists(backup_filename):
                shutil.copy2(filename, backup_filename)
                print(f"Created backup: {backup_filename}")
            else:
                print(
                    f"Backup already exists: {backup_filename}, skipping backup creation."
                )

            # Replace original with patched
            shutil.move(patched_filename, filename)
            print(f"Swapped {filename} with patched version")
            return True
        except Exception as e:
            print(f"Error swapping files: {e}")
            return False
    else:
        print(
            "To apply the patch, replace the original files with the patched files"
        )
        return True


class ArgumentParserWithHelp(argparse.ArgumentParser):
    def error(self, message):
        sys.stderr.write("error: %s\n" % message)
        self.print_help()
        sys.exit(2)


def main():
    parser = ArgumentParserWithHelp(
        description="IDA Pro 9.x",
        formatter_class=argparse.RawDescriptionHelpFormatter,
    )

    parser.add_argument(
        "--apply",
        action="store_true",
        help="Apply patches to original files (creates .bak backups)",
    )
    args = parser.parse_args()

    args.apply = args.apply

    success = True

    if args.apply:
        success_count = patch_ida_files(args.apply)
        success = success_count > 0

        if success_count == 0:
            print(
                "No files were patched. Ensure that you run this script from the IDA installation directory."
            )
            parser.print_help()
            return 1

    return 0 if success else 1


if __name__ == "__main__":
    exit(main())
