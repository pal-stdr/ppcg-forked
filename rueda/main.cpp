/// Header file calling practises

/// If you want to call headers from `rueda/include/*.{h,hpp}` dir to `rueda/*.{h,hpp,c,cpp}` (e.g. to `rueda/main.cpp`)
/// Follow: `#include <rueda.h>`
/// You can also use `#include <include/rueda.h>`, but not recommended.


/// If you want to call headers from `rueda/lib/*.{h,hpp}` dir to `rueda/*.{h,hpp,c,cpp}` (e.g. to `rueda/main.cpp`)
/// Follow: `#include <lib/rueda_options.h>`
/// You can also use `#include <rueda_options.h>`, but not recommended


/// If you want to call headers from `rueda/include/*.{h,hpp}` dir to `rueda/lib/*.{h,hpp,c,cpp}` (e.g. to `rueda/lib/rueda.cpp`)
/// Follow: `#include <rueda.h>`
/// You can also use `#include <include/rueda.h>`, but not recommended.


/// If you want to call headers from `rueda/lib/*.{h,hpp}` dir to `rueda/lib/*.{h,hpp,c,cpp}` (e.g. to `rueda/lib/rueda.cpp`)
/// Follow: `#include <rueda_options.h>`
/// You can also use `#include <lib/rueda_options.h>`, but not recommended


#include <rueda.hpp>
#include <rueda_options.h>
#include <gpu/rueda_gpu_options.h>

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
#include <iostream>
#include <nlohmann/json.hpp>
using json = nlohmann::json;

int main() {

    // Using initializer lists
    json ex3 = {
        {"happy", true},
        {"pi", 3.141},
    };

    // serialization with pretty printing
    // pass in the amount of spaces to indent
    std::cout << ex3.dump(4) << std::endl;

    // osl_scop_print_scoplib(NULL, NULL);
    return 0;
}