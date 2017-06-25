
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
        printf("logging: id %u hash %lu\n", id, hash);
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

void assert(uint64_t* hashVar, uint64_t hash)
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

}
