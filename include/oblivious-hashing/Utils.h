#pragma once

class unique_id_generator {
public:
  static unique_id_generator &get() {
    static unique_id_generator gen;
    return gen;
  }

public:
  unsigned next() { return id++; }

  unsigned current() { return id; }

  void reset() { id = 0; }

private:
  unique_id_generator() : id(0) {}

private:
  unsigned id;
};
