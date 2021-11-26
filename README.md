# basicray

A hardware accelerated ray tracer based on a simple version of [Ray Tracing in One Weekend](https://raytracing.github.io/books/RayTracingInOneWeekend.html). Currently, only the `intersect` function has been accelerated. This is a work in progress and only functions as an example for now. Written in C++ and Verilog.

## Dependencies
- [Icarus Verilog](http://iverilog.icarus.com/) for Verilog simulation
- g++ for C++ compilation

## Testing equivalence

To run the equivalence tests first run

```bash
sh test_prep.sh
```

Then run

```bash
sh intersect_tests/run_tbs.sh
```
