#include <iostream>
#include <fstream>
#include <vector>
#include <stdexcept>

class logger
{
public:
    logger()
        : max_log_count(2)
    {
        log_stream.open("hashes.log", std::ofstream::out|std::ofstream::trunc);
	log_stream.flush();
	log_stream.close();
    }

    void log(unsigned id, uint64_t hash)
    {
        log_stream.open("hashes.log", std::ofstream::out|std::ofstream::app);
        log_stream << id << " " << hash << "\n";
	log_stream.flush();
	log_stream.close();
    }

    void log_with_max_count(unsigned id, uint64_t hash)
    {
        unsigned size = log_counts.size();
//        printf("size %d\n", size);
        if (size <= id) {
            try {
                log_counts.resize(2 * (id + 1));
            } catch (const std::exception& e) {
                return;
            }
        }
        try {
            if (log_counts.at(id) >= max_log_count) {
                return;
            }
        } catch (const std::out_of_range& oor) {
            printf("out of range for for id %d\n", id);
            return;
        }
        //if (log_counts[id] >= max_log_count) {
        //    return;
        //}
        //printf("logging: id %u hash %lu\n", id, hash);
        log_stream << id << " " << hash << "\n";
        ++log_counts[id];
    }

    void finish()
    {
        printf("finish\n");
        log_stream.close();
    }

private:
    std::ofstream log_stream;
    unsigned max_log_count;
    std::vector<unsigned> log_counts;
};
extern "C" {

void oh_log(unsigned id, uint64_t* hashVar)
{
    static logger _logger;
    if (hashVar == NULL) {
        _logger.finish();
        return;
    }
    _logger.log(id, *hashVar);
}

void oh_input_dep_log(uint64_t* hashVar, uint64_t hashVal)
{
    //printf("Hash variable %lu prcumputed hash %lu\n", *hashVar, hashVal);
    // dummy function. only for assertion inserter to change to assert
}

}
