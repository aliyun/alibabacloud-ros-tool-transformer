export interface Meta {
  version: string;
  source_formats: string[];
  target_formats: string[];
  rules_classifiers: string[];
}

export interface TargetFile {
  filename: string;
  content: string;
  is_binary: boolean;
}

export interface TransformResponse {
  targets: TargetFile[];
  log: string;
}

export interface ApiError {
  type: string;
  message: string;
  log?: string;
}

export interface ExampleMeta {
  id: string;
  title: string;
  source_format: string;
  filename: string;
  language: string;
}

export interface Example extends ExampleMeta {
  content: string;
}

export interface TransformOptions {
  compatible?: boolean;
  extra_files?: string[];
  credentials?: {
    access_key_id?: string;
    access_key_secret?: string;
  };
}
