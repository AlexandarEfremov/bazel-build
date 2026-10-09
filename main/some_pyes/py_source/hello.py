def greet_me() -> str:
    print("What's your name?", end=' ')
    name = input()
    return f"Hello, {name}! How are you today?"

def main() -> None:
    print(greet_me())
    print("All parts of the script have executed!")

if __name__ == "__main__":
    main()