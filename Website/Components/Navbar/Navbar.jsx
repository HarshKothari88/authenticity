import Link from "next/link";

const navlinks = [
  {
    name: "Pricing",
    link: "/pricing",
  },
  {
    name: "About",
    link: "/about",
  },
  {
    name: "API",
    link: "/api",
  },
];

const Navbar = () => {
  return (
    <div className="navbar p-5 w-full h-[70px] border flex  items-center justify-between fixed top-0 left-0 bg-white z-50">
      <Link href="/">
        <div className="logo">
          <h1 className="text-3xl font font-bold text-black">
            Authenti<span className=" text-primary">FY</span>
          </h1>
        </div>
      </Link>
      <div className="links flex  items-center justify-between gap-10 text-[17px]">
        {navlinks.map((link, index) => {
          return (
            <Link
              href={link.link}
              key={index}
              className=" text-tertiary hover:text-primary hover:scale-110"
            >
              {link.name}
            </Link>
          );
        })}
      </div>
      <div className="btns flex gap-3 items-center">
        <Link href="/login" className="btn-secondary">
          Login
        </Link>
        <Link href="/register" className="btn-primary">
          Start Trial
        </Link>
      </div>
    </div>
  );
};

export default Navbar;
