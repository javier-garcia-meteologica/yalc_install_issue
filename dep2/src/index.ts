import chalk from 'chalk2';

export function configurable(value: boolean) {
  return function (
    // eslint-disable-next-line
    target: any,
    propertyKey: string,
    descriptor: PropertyDescriptor
  ): void {
    descriptor.configurable = value;
  };
}

class Greeter {
  name: string;
  constructor(name: string) {
    this.name = name;
  }

  @configurable(false)
  get greeting (): string {
    return `Hello ${this.name}!`;
  }

  greet (): void {
    console.log(chalk.blue(this.greeting));
  }
}

export { Greeter };
