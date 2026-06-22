import { useState } from "react";
import {
  IconChevronDown,
  IconChevronRight,
  IconFile,
  IconFolder,
  IconFolderOpen,
} from "@tabler/icons-react";
import type { TreeNode } from "../util";

interface Props {
  nodes: TreeNode[];
  selected: string | null;
  onSelect: (node: TreeNode) => void;
}

export function FileTree({ nodes, selected, onSelect }: Props) {
  return (
    <div className="filetree">
      {nodes.map((n) => (
        <TreeItem
          key={n.path}
          node={n}
          depth={0}
          selected={selected}
          onSelect={onSelect}
        />
      ))}
    </div>
  );
}

function TreeItem({
  node,
  depth,
  selected,
  onSelect,
}: {
  node: TreeNode;
  depth: number;
  selected: string | null;
  onSelect: (node: TreeNode) => void;
}) {
  const [open, setOpen] = useState(true);
  const pad = 8 + depth * 14;

  if (node.isDir) {
    return (
      <div>
        <div
          className="tree-row"
          style={{ paddingLeft: pad }}
          onClick={() => setOpen((v) => !v)}
        >
          {open ? (
            <IconChevronDown size={14} className="tree-chevron" />
          ) : (
            <IconChevronRight size={14} className="tree-chevron" />
          )}
          {open ? (
            <IconFolderOpen size={15} className="tree-icon folder" />
          ) : (
            <IconFolder size={15} className="tree-icon folder" />
          )}
          <span className="tree-name">{node.name}</span>
        </div>
        {open &&
          node.children?.map((c) => (
            <TreeItem
              key={c.path}
              node={c}
              depth={depth + 1}
              selected={selected}
              onSelect={onSelect}
            />
          ))}
      </div>
    );
  }

  return (
    <div
      className={`tree-row file${selected === node.path ? " active" : ""}`}
      style={{ paddingLeft: pad + 14 }}
      onClick={() => onSelect(node)}
    >
      <IconFile size={15} className="tree-icon" />
      <span className="tree-name">{node.name}</span>
    </div>
  );
}
