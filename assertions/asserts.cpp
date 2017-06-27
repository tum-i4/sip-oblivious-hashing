
#include <iostream>
#include <fstream>

class logger
{
public:
    logger()
    {
        log_stream.open("hashes.log");
    }

    void log(unsigned id, uint64_t hash)
    {
        //printf("logging: id %u hash %lu\n", id, hash);
        log_stream << id << " " << hash << "\n";
    }

    void finish()
    {
        log_stream.close();
    }

private:
    std::ofstream log_stream;
};

extern "C" {

void log(unsigned id, uint64_t* hashVar)
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

void assert(uint64_t* hashVar, int values_count, ...)
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
