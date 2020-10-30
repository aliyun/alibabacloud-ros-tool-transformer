import os
import platform

from ctypes import cdll, c_char_p


def parse(tf_dir: str) -> str:

    system = platform.system()
    lib = cdll.LoadLibrary(os.path.join(os.path.dirname(os.path.abspath(__file__)), f"parse_{system.lower()}.so"))
    parser_tf = lib.ParserTf

    parser_tf.argtype = c_char_p
    parser_tf.restype = c_char_p

    output = parser_tf(tf_dir.encode())

    return output.decode()
