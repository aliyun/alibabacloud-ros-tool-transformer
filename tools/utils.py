def snake_to_camel(snake_str: str):
    words = snake_str.split("_")
    camel_str = "".join(word.title() for word in words)
    return camel_str
