import argparse


def hex_to_bin(hex_file, bin_file, verbose=False):
    try:
        with open(hex_file, "r") as hex_f:
            # Read the hex file content
            hex_data = hex_f.read().strip()

        # Convert the hex data to binary
        binary_data = bytes.fromhex(hex_data)

        # Write the binary data to a file
        with open(bin_file, "wb") as bin_f:
            bin_f.write(binary_data)

        if verbose:
            print(
                f"Hex data has been successfully converted to binary and saved as {bin_file}"
            )
        else:
            print(f"Binary file saved as {bin_file}")
    except Exception as e:
        print(f"Error: {e}")


def main():
    # Set up the argument parser
    parser = argparse.ArgumentParser(description="Convert a hex file to binary.")

    # Define the arguments
    parser.add_argument("--input", required=True, help="Path to the input hex file")
    parser.add_argument(
        "--output", required=True, help="Path to the output binary file"
    )
    parser.add_argument("--verbose", action="store_true", help="Enable verbose output")

    # Parse the arguments
    args = parser.parse_args()

    # Call the conversion function
    hex_to_bin(args.input, args.output, args.verbose)


if __name__ == "__main__":
    main()
