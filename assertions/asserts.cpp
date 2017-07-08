
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
        log_stream.open("hashes.log");
    }

    void log(unsigned id, uint64_t hash)
    {
        unsigned size = log_counts.size();
        printf("size %d\n", size);
        if (size <= id) {
            try {
                log_counts.resize(2 * (id + 1));
            } catch (const std::exception& e) {
                printf("yah %d\n", id);
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
        printf("logging: id %u hash %lu\n", id, hash);
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

void oh_assert(uint64_t* hashVar, int values_count, ...)
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
        std::cout << "Fail: " << *hashVar << " != " << hash << "\n";
        abort();
    }

}

}
