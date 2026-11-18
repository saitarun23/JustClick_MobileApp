import { useEffect, useState } from "react";
import { Gift, MessageCircle, ArrowUp } from "lucide-react";

export default function FloatingButtons() {
  const [show, setShow] = useState(false);

  useEffect(() => {
    const onScroll = () => setShow(window.scrollY > 400);
    window.addEventListener("scroll", onScroll);
    return () => window.removeEventListener("scroll", onScroll);
  }, []);

  return (
    <>
      <button className="fab fab-gift" aria-label="Offers"><Gift size={26} /></button>

      {show && (
        <button
          className="fab fab-top"
          aria-label="Back to top"
          onClick={() => window.scrollTo({ top: 0, behavior: "smooth" })}
        >
          <ArrowUp size={24} />
        </button>
      )}

      <a href="#" className="fab fab-chat">
        <MessageCircle size={20} /> Chat with us
      </a>
    </>
  );
}