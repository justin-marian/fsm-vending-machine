# Vending Machine

Simple vending machine designed to dispense products based on user input and provide change when necessary. The vending machine operates in three main states: `Idle`, `Money`, and `Product & Change`.

## States

### Idle

- In this state, the vending machine **awaits user input**.
- Upon **receiving money** or a request for a product, it transitions to the `Money` state.
- Upon **receiving a request** for change, it transitions directly to the `Product & Change` state.

### Money

- In this state, the vending machine processes the user's **money input**.
- If the user requests a product (`product_x` or `product_y`), it checks if there's enough money to **dispense the selected product**.
- For **insufficient funds**, it returns to the `Idle` state.
- For **enough money**, gives the product and goes back to the `Idle` state.

### Product & Change

- Calculates the **remaining change** to be returned to the user.
- It calculates the change in terms of `1 Lei` and `50 Bani`.
- After calculating the change, it transitions back to the `Idle` state.

## Inputs and Outputs

***Inputs:***

- `input_50bani`: Indicates insertion of a `50 Bani`.
- `input_1lei`: Indicates insertion of a `1 Lei`.
- `input_5lei`: Indicates insertion of a `5 Lei`.
- `reset`: Resets the vending machine.
- `clk`: Clock input.
- `get_product_x`: Request for product `X`.
- `get_product_y`: Request for product `Y`.
- `change`: Request for change.

***Outputs:***

- `give_product_x`: Signal to dispense product `X`.
- `give_product_y`: Signal to dispense product `Y`.
- `give_remaining_50bani`: Signal to dispense rest `50 Bani` as change.
- `give_remaining_1lei`: Signal to dispense rest `1 Lei` as change.

## Usage

Instantiate the vending machine module in your Verilog design and connect the inputs and outputs as described above. Simulate or synthesize the design to observe the behavior of the vending machine.
