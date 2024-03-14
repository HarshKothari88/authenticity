"use client";
import Link from "next/link";
import Image from "next/image";

export const HomePage = () => {
  const randomImageNumber = Math.floor(Math.random() * 3) + 1;
  return (
    <>
      <section className="home w-full flex">
        <div className="w-1/2 h-screen px-20 flex flex-col gap-4 justify-center items-start">
          <div className="info flex gap-2 mt-[-30px]">
            <h1 className="text-primary bg-[#F2EFFF] px-2 py-1 rounded-xl">
              AI Powered Platform
            </h1>
            <div className="flex gap-1 justify-center items-center">
              <img src="./star.svg" height="15" width="15" />
              <img src="./star.svg" height="15" width="15" />
              <img src="./star.svg" height="15" width="15" />
              <img src="./star.svg" height="15" width="15" />
            </div>
            <h1 className="py-1">100+ TRUSTPILOT</h1>
          </div>
          <h1 className=" text-7xl  font-medium">
            One solution <br />
            for <span className=" text-[#5f45f2]">
              Streamlining
            </span> <br /> your KYC
          </h1>
          <h2 className=" text-lg text-tertiary leading-6">
            A versatile solution for verifying customer identity, simplifying
            the KYC registration process and managing the entire customer
            lifecycle.
          </h2>
          <div className="clicks mt-5">
            <Link
              href="/register"
              className="btn-primary px-6 py-4  text-lg font-medium flex gap-2 "
            >
              GET STARTED{" "}
              <img
                width="20px"
                height="10px"
                src="https://img.icons8.com/ios-glyphs/30/ffffff/long-arrow-right.png"
                alt="long-arrow-up"
                className="rotate-[-35deg]"
              />
            </Link>
          </div>
        </div>
        <div className="w-1/2 h-screen flex flex-col items-center justify-center">
          {/* <img src="/2.jpg" className="mt-[-50px]  max-h-[90%] animateupdown" /> */}
          <img
           src={`/${randomImageNumber}.jpg`}
            className="mt-[-50px]  max-h-[90%] animateupdown"
          />
        </div>
      </section>
      <section className=" bg-[#F6F9FD] min-h-[350px] flex flex-col items-center justify-center gap-5">
        <h2 className=" bg-[#b776f8] text-sm text-white px-3 py-1  rounded-2xl">Let Check Our Service 🔥</h2>
        <h1 className=" text-center text-6xl font-semibold">Your comfort is our <br /> <span className="text-[#5f45f2] font-semibold">happiness</span></h1>
        <Link href="pricing" className="btn-primary px-5 py-3  text-lg font-medium flex gap-2 ">CHECK OUR PRODUCT</Link>
      </section>
      <div></div>
    </>
  );
};
