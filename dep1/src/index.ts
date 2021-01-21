import { Greeter, configurable } from '@deps/dep2';

class InformalGreeter extends Greeter {
  @configurable(false)
  get greeting (): string {
    return `Hi ${this.name}!`;
  }
}

export { InformalGreeter };
