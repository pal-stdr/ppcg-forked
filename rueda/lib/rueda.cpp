// Following headers are coming from rueda/include/
#include <rueda.hpp>
#include <rueda_options.h>
#include <rueda_gpu.h>
#include <rueda_gpu_options.h>

#include "osl/body.h"
#include "osl/extensions/arrays.h"
#include "osl/extensions/dependence.h"
#include "osl/extensions/loop.h"
#include "osl/extensions/pluto_unroll.h"
#include "osl/extensions/scatnames.h"
#include "osl/macros.h"
#include "osl/relation_list.h"
#include "osl/scop.h"


#include <fstream>
#include <nlohmann/json.hpp>
using json = nlohmann::json;


