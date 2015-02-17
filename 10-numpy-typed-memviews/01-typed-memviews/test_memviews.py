import pyximport; pyximport.install()

import memviews
import numpy as np
from array import array

arr = np.ones((10**6,), dtype=np.double)
print memviews.summer(arr)
# => 1000000.0

a = array('d', [1]*10**6)
print len(a)
# => 1000000

print memviews.summer(a)
# => 1000000.0
