#include <cstdint>

#include <gtest/gtest.h>

#include "mylib.h"

constexpr uintmax_t NUMBER = 256;

TEST(MylibTests, Init) {
  auto myobj = std::make_unique<Mylib>(NUMBER);
  ASSERT_EQ(myobj->mylibMethod(), NUMBER);
}
