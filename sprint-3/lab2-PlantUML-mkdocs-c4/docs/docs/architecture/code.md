## Code Diagram

```puml
@startuml
package "Commands" {
  class CreateOrderCommand {
    +execute()
  }
  class UpdateCourierStatusCommand {
    +execute()
  }
  class CompleteDeliveryCommand {
    +execute()
  }
}

package "Queries" {
  class GetCourierLocationQuery {
    +execute()
  }
  class GetActiveOrdersQuery {
    +execute()
  }
  class GetDeliveryHistoryQuery {
    +execute()
  }
}

class OrderService {
  +handleCommand()
  +handleQuery()
}

OrderService --> CreateOrderCommand : handles
OrderService --> UpdateCourierStatusCommand : handles
OrderService --> CompleteDeliveryCommand : handles
OrderService --> GetCourierLocationQuery : handles
OrderService --> GetActiveOrdersQuery : handles
OrderService --> GetDeliveryHistoryQuery : handles
@enduml

```