#include <gtest/gtest.h>
#include <cstdint>
#include <mylib.h>

constexpr uintmax_t NUMBER = 256;

class MylibTests : public testing::Test {
protected:
	Mylib* myobj;

	void SetUp() override {
		myobj = new Mylib(NUMBER);
	}

	void TearDown() override {
		delete myobj;
	}
};

TEST_F(MylibTests, Init) {
	ASSERT_EQ(myobj->mylibMethod(), NUMBER);
}
