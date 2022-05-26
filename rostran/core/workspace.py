from rostran.core.exceptions import InvalidTemplateWorkspace


class WorkspaceFile:
    def __init__(self, filename, content):
        self.filename = filename
        self.content = content


class Workspace(dict):
    @classmethod
    def initialize(cls, data: dict):
        if not isinstance(data, dict):
            raise InvalidTemplateWorkspace(
                reason=f"The type of data ({data}) should be dict"
            )

        workspace = cls()
        for filename, content in data.items():
            param = WorkspaceFile(filename, content)
            workspace.add(param)
        return workspace

    def add(self, f: WorkspaceFile):
        self[f.filename] = f

    def as_dict(self, format=False) -> dict:
        data = {}
        keys = self.keys()
        if format:
            keys = sorted(keys)
            if "main.tf" in keys:
                keys.remove("main.tf")
                keys.insert(0, "main.tf")

        for key in keys:
            param: WorkspaceFile = self[key]
            data[key] = param.content
        return data
