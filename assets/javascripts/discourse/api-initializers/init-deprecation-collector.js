import { apiInitializer } from "discourse/lib/api";

export default apiInitializer("0.8", (api) => {
  api.container.lookup("service:deprecation-collector");
});
