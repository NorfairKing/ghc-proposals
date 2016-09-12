.. proposal-number:: Leave blank. This will be filled in when the proposal is
                     accepted.

.. trac-ticket:: Leave blank. This will eventually be filled with the Trac
                 ticket number which will track the progress of the
                 implementation of the feature.

.. implemented:: Leave blank. This will be filled in with the first GHC version which
                 implements the described feature.

Safe splices
==============

Here you should write a short abstract motivating and briefly summarizing the proposed change.

Motivation
----------

Template Haskell code has to be re-compiled every compilation.

Proposed Change
---------------

1. Define safe splices
a splice is safe if all it's referenced expressions are defined in external packages.

Don't recompile if a module only contains safe splices.

Drawbacks
---------

TODO

Alternatives
------------

TODO

Unresolved Questions
--------------------

TODO
