import { Detail, ActionPanel, CopyToClipboardAction } from "@raycast/api";
import React, { useEffect, useState } from "react";
import Endpoint from "../model/Endpoint";
import EndpointRepository from "../repository/EndpointRepository";

interface Props {
  path: string;
  method: string;
}

function EndpointSingle({ path, method }: Props) {
  const [endpoint, setEndpoint] = useState<Endpoint | null>(null);

  useEffect(() => {
    const fetchEndpoint = async () => {
      const repository = new EndpointRepository();
      const endpoint = await repository.getEndpoint(path, method);
      // @ts-ignore
        setEndpoint(endpoint);
    };

    fetchEndpoint();
  }, [path, method]);

  return (
    endpoint ? (
      <Detail
        markdown={`# ${endpoint.method} ${endpoint.path}\n\n${endpoint.description}`}
      />
    ) : (
      <Detail markdown="# Loading..." />
    )
  );
}

export default EndpointSingle;