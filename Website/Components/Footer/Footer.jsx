const Footer = () => {
  return (
    <>
      <div className="relative top-[70px] w-full min-h-[100px] bg-[#130326] flex-col justify-center items-center pt-5">
        <div className=" absolute top-0 min-h-[10px] w-full bg-primary"></div>
        <div className="flex h-[200px]">
          <div className="w-1/2 flex items-center justify-end px-10">
            <h1 className="text-white text-3xl text-center font-medium">
              Experience the power of <br />{" "}
              <span className="text-[#5f45f2] text-4xl">Automation</span>
            </h1>
          </div>
          <div className="right w-1/2 flex items-center justify-start px-10">
            <div className="relative bg-gray-300 w-[350px] h-[50px] rounded-lg overflow-hidden">
              <input
                type="text"
                placeholder="Enter Email"
                className="bg-gray-300 w-full h-full px-2 outline-0 placeholder:text-primary"
              />
              <button className="btn-primary absolute top-2 right-2">
                Submit
              </button>
            </div>
          </div>
        </div>
        <div className="w-full flex  items-center justify-center my-5">
          <div className="w-[70%] h-[1px] bg-slate-500"></div>
        </div>
        <h1 className="text-4xl font font-bold text-center text-white">
        Authenti<span className=" text-primary">FY</span>
        </h1>
        <h1 className=" text-center text-xl text-white"><pre> </pre></h1>
      </div>
    </>
  );
};

export default Footer;
