# super-resolution-pr-emse
An image super-resolution algorithm coded in MATLAB using an article by _Tsz Chun Ho_ and _Bing Zeng_. See [Super resolution image by edge-constrained curve fitting in the threshold decomposition domain](https://pdfs.semanticscholar.org/14fb/a4d942155b8678c1a601a683b943d67e42f3.pdf "Semanticscholar").

This work is done for a small research project at the [Ecole des Mines de Saint-Etienne](http://www.mines-stetienne.fr/ "EMSE").

The function to call is: `super_resolution(I, f, delta)` where `I` is the image to super-resolved, `f` the factor of enlargement and `delta` a number indicating if edge correction should be performed. The recommended value od `delta` is between `0` and `1` (if set to `-1`, no edge correction is performed).
