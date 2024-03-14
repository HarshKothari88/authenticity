import "./globals.css";

import Navbar from "@/Components/Navbar/Navbar";
import Footer from "@/Components/Footer/Footer";

export const metadata = {
  title: "KYC",
  description: "",
};

export default function RootLayout({ children }) {
  return (
    <html lang="en">
      <head>
      <link rel="icon" href="/logo.png" />
      </head>
      <body>
        <Navbar />
        <section className="relative top-[72px] min-h-fullscreen">
          {children}
        </section>
        <Footer />
      </body>
    </html>
  );
}
