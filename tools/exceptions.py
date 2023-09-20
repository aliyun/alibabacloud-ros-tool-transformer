class RosToolException(Exception):
    msg = "{message}."

    def __init__(self, **kwargs):
        self.kwargs = kwargs
        self.message = self.msg.format(**kwargs)

    def __str__(self):
        return self.message


class RosToolWarning(RosToolException):
    msg = "{message}."
