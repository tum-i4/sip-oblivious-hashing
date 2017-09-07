#include <iostream>
#include <fstream>
#include <vector>
#include <stdexcept>
#include <stdint.h>
extern "C" {

	void assert_(uint64_t* hashVar, uint64_t hash)
	{
		if (hashVar == nullptr) {
			return;
		}
		if (*hashVar != hash) {
			std::cout << "Fail: " << *hashVar << " != " << hash << "\n";
			abort();
		} else {
			std::cout << "Pass\n";
		}
	}

	void oh_assert_dumper(unsigned id, uint64_t* hashVar, int values_count, ...)
	{
		if (hashVar == nullptr) {
			std::cout << "Pass\n";
			return;
		}
		bool is_valid = false;
		uint64_t hash = 0;
		va_list args_list;
		va_start(args_list, values_count);
		std::ofstream log_stream;
		log_stream.open("hashes_dumper.log", std::ofstream::out|std::ofstream::app);
		log_stream << id << " " << *hashVar << "\n";
		log_stream.flush();
		log_stream.close();
		//for (unsigned i = 0; i < values_count; ++i) {
		//   hash = va_arg(args_list, uint64_t);
		//if (*hashVar == hash) {
		//    is_valid = true;
		//    break;
		//}
		//}
		//if (!is_valid) {
		//if (hash == 272) {
		//    return;
		//}
		//  std::cout << "Fail: " << *hashVar << " != " << hash << "\n";
		//  abort();
		//}

	}


	void oh_assert_finalize(unsigned id, uint64_t* hashVar, int values_count, ...)
	{
		if (hashVar == nullptr) {
			std::cout << "Pass\n";
			return;
		}
		bool is_valid = false;
		uint64_t hash = 0;
		va_list args_list;
		va_start(args_list, values_count);
		for (unsigned i = 0; i < values_count; ++i) {
			hash = va_arg(args_list, uint64_t);
			if (*hashVar == hash) {
				is_valid = true;
				break;
			}
		}
		if (!is_valid) {
			//if (hash == 272) {
			//    return;
			//}
			std::cout << "Fail for hashID:"<<id << " computed: " << *hashVar << " != last expected " << hash << "\n";
			abort();
		}

	}

}
