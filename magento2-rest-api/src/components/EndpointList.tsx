import { useEffect, useState } from 'react';
import { Action, ActionPanel, List } from "@raycast/api";
import Endpoint from '../model/Endpoint';
import EndpointRepository from '../repository/EndpointRepository';
import EndpointSingle from './EndpointSingle';

const EndpointList: React.FC = () => {
  const [endpoints, setEndpoints] = useState<Endpoint[]>([]);

  useEffect(() => {
    const fetchEndpoints = async () => {
      const repository = new EndpointRepository();
      const endpoints = await repository.getEndpoints();
      setEndpoints(endpoints);
    };

    fetchEndpoints();
  }, []);

  return (
    <List isLoading={endpoints.length === 0}>
      {endpoints.map((endpoint, index) => (
        <List.Item
          key={index} // Add this line
          id={index.toString()}
          title={`${endpoint.method} ${endpoint.path}`}
          subtitle={endpoint.description}
          actions={
            <ActionPanel>
              <Action.Push
                title="View Details"
                target={<EndpointSingle path={endpoint.path} method={endpoint.method} />}
              />
            </ActionPanel>
          }
        />
      ))}
    </List>
  );
};

export default EndpointList;