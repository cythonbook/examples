#ifndef __HISTOGRAM_H__
#define __HISTOGRAM_H__

#include <vector>

#include "boost/shared_ptr.hpp"

boost::shared_ptr<std::vector<int> > histogram(const std::vector<int>& data);

#endif
