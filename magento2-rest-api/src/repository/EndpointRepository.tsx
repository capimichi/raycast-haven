import Endpoint from '../model/Endpoint';
import fetch from 'node-fetch';

class EndpointRepository {
  private static readonly ENDPOINT_URL = 'https://raw.githubusercontent.com/Strategery-Inc/magento2-swagger-definitions/master/commerce/2.4.0/admin/c240-admin-all.json';

  public async getEndpoints(): Promise<Endpoint[]> {
        const response = await fetch(EndpointRepository.ENDPOINT_URL);
        const data = await response.json();

        const endpoints: Endpoint[] = [];

        // @ts-ignore
      for (const path in data.paths) {
            // @ts-ignore
          for (const method in data.paths[path]) {
                // @ts-ignore
              const endpoint: Endpoint = {
                    path: path,
                    method: method,
                    description: data.paths[path][method].description,
                };
                endpoints.push(endpoint);
            }
        }

        return endpoints;
    }

    async getEndpoint(path: string, method: string) {
        const endpoints = await this.getEndpoints();
        return endpoints.find((endpoint) => endpoint.path === path && endpoint.method === method);
    }
}

export default EndpointRepository;