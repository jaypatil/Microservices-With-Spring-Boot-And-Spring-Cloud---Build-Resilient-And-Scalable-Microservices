package example.microservices.core.product;

import org.springframework.test.context.DynamicPropertyRegistry;
import org.springframework.test.context.DynamicPropertySource;
import org.testcontainers.containers.MongoDBContainer;
import org.testcontainers.utility.DockerImageName;

public abstract class MongoDbTestBase {

  private static MongoDBContainer database = new MongoDBContainer(DockerImageName.parse("mongo:latest"));
  
  static {
    database.start();
  } 
  
  @DynamicPropertySource
  static void setProperties(DynamicPropertyRegistry registry) {
    registry.add("spring.data.mongodb.host", database::getContainerIpAddress);
    registry.add("spring.data.mongodb.port", () -> database.getMappedPort(27017));
    registry.add("spring.data.mongodb.database", () -> "test");
  }
}
