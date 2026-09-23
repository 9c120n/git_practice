# H2 + D2 -> 2 HD: gas-phase thermochemistry

## Result

At 298.15 K and 1 atm, B3LYP/6-31G(d) harmonic-RRHO gives the following
standard reaction quantities (products minus reactants):

| quantity | raw ORCA (sigma=1 for every species) | symmetry-corrected value |
| --- | ---: | ---: |
| Delta H | +0.00025244 Eh = +0.1584 kcal mol-1 = +0.6628 kJ mol-1 | unchanged |
| Delta G | +0.00019695 Eh = +0.1236 kcal mol-1 = +0.5171 kJ mol-1 | **-0.00111197 Eh = -0.6978 kcal mol-1 = -2.9195 kJ mol-1** |

The recommended result is the symmetry-corrected Delta G: **-2.92 kJ mol-1**.
It corresponds to an ideal-gas equilibrium constant of approximately 3.25 at
298.15 K (`exp(-Delta G/RT)`).

## Calculation

- Electronic structure: ORCA 6.0.1, B3LYP/6-31G(d), `TightSCF`, geometry
  optimization followed by analytic harmonic frequencies.
- Thermochemistry: ideal-gas RRHO, 298.15 K and 1.00 atm; `QuasiRRHO false`.
- Isotopes: each nucleus was specified with ORCA's coordinate-level `M =`
  mass option (H-1 = 1.00782503223 u; D-2 = 2.01410177812 u).
- Resources: one Slurm node, one CPU core; batch job 14071 on node4.
- Wall times: H2 130.5 s; D2 199.4 s; HD 200.2 s.

## Species-level output

All values below are in Eh; the entropy columns are T*S at 298.15 K.

| species | E(el) | ZPE | E(vib) | E(rot) | E(trans) | H | T*S(rot) | T*S(trans) | G |
| --- | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: |
| H2 | -1.16876156 | 0.01014062 | 0.00000000 | 0.00094418 | 0.00141627 | -1.15531628 | 0.00210497 | 0.01334179 | -1.17076305 |
| D2 | -1.16876156 | 0.00717326 | 0.00000000 | 0.00094418 | 0.00141627 | -1.15828364 | 0.00275871 | 0.01432239 | -1.17536474 |
| HD | -1.16876156 | 0.00878316 | 0.00000000 | 0.00094418 | 0.00141627 | -1.15667374 | 0.00237636 | 0.01391532 | -1.17296542 |

The electronic and finite-temperature vibrational entropy terms are zero at
this temperature to ORCA's printed precision. The harmonic stretches are
4451.22 (H2), 3148.70 (D2), and 3855.36 cm-1 (HD).

## Reaction-term decomposition

`Delta` means `2*HD - H2 - D2`; kcal mol-1 values use 627.509474
kcal mol-1 Eh-1.

| contribution | Delta quantity (Eh) | contribution to Delta H or -T*Delta S (kcal mol-1) |
| --- | ---: | ---: |
| electronic energy | 0.00000000 | 0.0000 |
| zero-point vibration | +0.00025244 | +0.1584 (Delta H) |
| finite-temperature vibration | 0.00000000 | 0.0000 (Delta H) |
| rotation and translation energy, including pV | 0.00000000 | 0.0000 (Delta H) |
| electronic entropy | 0.00000000 | 0.0000 (-T*Delta S) |
| vibrational entropy | 0.00000000 | 0.0000 (-T*Delta S) |
| rotational entropy, raw ORCA | -0.00011096 (T*Delta S) | +0.0696 (-T*Delta S) |
| translational entropy | +0.00016646 (T*Delta S) | -0.1045 (-T*Delta S) |
| **raw total -T*Delta S** | +0.00005550 (T*Delta S) | **-0.0348** |

## Rotational-symmetry correction

ORCA printed symmetry number 1 for H2, D2, and HD. For the conventional
rigid-rotor molecular partition function, H2 and D2 are homonuclear and use
sigma=2, whereas HD uses sigma=1. Applying the missing `RT ln(2)` reduction
to each reactant rotational entropy increases `T*Delta S` by
`2 RT ln(2) = 0.00130891 Eh = 0.82135 kcal mol-1`.

Thus the corrected `-T*Delta S` is **-0.85618 kcal mol-1**, dominated by the
rotational symmetry/statistical factor; adding the +0.15841 kcal mol-1
enthalpy contribution gives the reported **Delta G = -0.69777 kcal mol-1**.

This is a rotational symmetry-number correction, not a nuclear-spin
ortho/para partition-function treatment. Nuclear-spin statistical populations
are not included; adding them requires an explicitly specified spin-isomer
ensemble and would define a different thermodynamic model.

## Files

- `../h2.inp`, `../d2.inp`, `../hd.inp`: raw ORCA inputs.
- `../h2.out`, `../d2.out`, `../hd.out`: complete ORCA outputs.
- `../run_orca_thermo.sbatch`: one-node/one-core Slurm batch script.

## MAESTRO support note

MAESTRO's `ThermoTask` produces RRHO terms, but it cannot apply isotope masses
to the full thermochemistry calculation; `IsotopeShiftTask` only recalculates
frequencies. The missing task is an isotope-aware thermochemistry task, so
the isotope-specific ORCA calculation was run directly.
