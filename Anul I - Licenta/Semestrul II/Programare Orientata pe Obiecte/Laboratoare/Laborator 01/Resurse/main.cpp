#include "vector.h"
#include "tests.cpp"

int main() {
    test::default_allocator();
    test::sized_allocator();
    test::random_access();
    test::sized_value_allocator();
    test::front_back();
    test::front_back_const();
    test::begin_end();
    test::push_back();
    test::pop_back();
    test::clear();
    test::resize();
    test::reserve();
    test::shrink_to_fit();

    // testez push_back()
    // v.push_back(5);
    // v.push_back(3);
    // std::cout << "front: " << v.front() << std::endl;
    // std::cout << v.back() << std::endl;
    // v.front() = 7;
    // std::cout << v.front() << std::endl;
    return 0;
}
