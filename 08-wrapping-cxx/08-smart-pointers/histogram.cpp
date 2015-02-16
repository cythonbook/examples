#include "histogram.h"
#include <algorithm>
#include <iostream>
#include "boost/make_shared.hpp"

boost::shared_ptr<std::vector<int> > histogram(const std::vector<int>& data)
{
    const int max_elt = *std::max_element(data.begin(), data.end());
    boost::shared_ptr<std::vector<int> > phist = boost::make_shared<std::vector<int> >(max_elt+1);
    std::vector<int>& hist = *phist;
    for (std::vector<int>::const_iterator it=data.begin(); it != data.end(); ++it)
        hist[*it] += 1;
    return phist;
}
