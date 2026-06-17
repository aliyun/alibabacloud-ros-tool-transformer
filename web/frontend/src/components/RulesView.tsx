import { useEffect, useState } from "react";
import { getRules, TransformApiError } from "../api";

interface Props {
  classifiers: string[];
}

export function RulesView({ classifiers }: Props) {
  const [classifier, setClassifier] = useState(classifiers[0] ?? "cloudformation");
  const [content, setContent] = useState("");
  const [busy, setBusy] = useState(false);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    let cancelled = false;
    setBusy(true);
    setError(null);
    getRules(classifier)
      .then((c) => {
        if (!cancelled) setContent(c);
      })
      .catch((e: unknown) => {
        if (!cancelled) {
          setError(e instanceof TransformApiError ? e.message : String(e));
          setContent("");
        }
      })
      .finally(() => {
        if (!cancelled) setBusy(false);
      });
    return () => {
      cancelled = true;
    };
  }, [classifier]);

  return (
    <div className="rules-view">
      <div className="rules-bar">
        <label>Rules</label>
        <select
          value={classifier}
          onChange={(e) => setClassifier(e.target.value)}
        >
          {classifiers.map((c) => (
            <option key={c} value={c}>
              {c}
            </option>
          ))}
        </select>
      </div>
      {error && <div className="banner error">{error}</div>}
      {busy ? (
        <div className="result empty">
          <div className="spinner" />
        </div>
      ) : (
        <pre className="rules-body">{content}</pre>
      )}
    </div>
  );
}
