import { useEffect, useRef } from "react";
import { ActionIcon, Loader, Tooltip } from "@mantine/core";
import {
  IconChevronDown,
  IconChevronUp,
  IconTerminal2,
  IconTrash,
} from "@tabler/icons-react";

interface Props {
  text: string;
  running: boolean;
  collapsed: boolean;
  height: number;
  onToggle: () => void;
  onClear: () => void;
}

export function LogConsole({
  text,
  running,
  collapsed,
  height,
  onToggle,
  onClear,
}: Props) {
  const bodyRef = useRef<HTMLPreElement>(null);

  useEffect(() => {
    const el = bodyRef.current;
    if (el) el.scrollTop = el.scrollHeight;
  }, [text, collapsed]);

  return (
    <div
      className="log-drawer"
      style={collapsed ? undefined : { height }}
    >
      <div className="log-head" onClick={onToggle}>
        <IconTerminal2 size={15} />
        <span>Logs</span>
        {running && <Loader size={13} color="gray" />}
        <div className="log-head-spacer" />
        {text && !collapsed && (
          <Tooltip label="Clear" withArrow>
            <ActionIcon
              variant="subtle"
              color="gray"
              size="sm"
              onClick={(e) => {
                e.stopPropagation();
                onClear();
              }}
            >
              <IconTrash size={14} />
            </ActionIcon>
          </Tooltip>
        )}
        {collapsed ? <IconChevronUp size={16} /> : <IconChevronDown size={16} />}
      </div>
      {!collapsed && (
        <pre className="log-body" ref={bodyRef}>
          {text || (running ? "Starting…" : "Conversion logs will appear here.")}
        </pre>
      )}
    </div>
  );
}
