import { Children, useEffect, useRef, useState } from "react";
import { ChevronLeft, ChevronRight } from "lucide-react";

export default function Carousel({ children }) {
  const ref = useRef(null);
  const [pages, setPages] = useState(1);
  const [active, setActive] = useState(0);
  const count = Children.count(children);

  const measure = () => {
    const el = ref.current;
    if (!el) return;
    setPages(Math.max(1, Math.round(el.scrollWidth / el.clientWidth)));
    setActive(Math.round(el.scrollLeft / el.clientWidth));
  };

  useEffect(() => {
    measure();
    window.addEventListener("resize", measure);
    return () => window.removeEventListener("resize", measure);
  }, [count]);

  const go = (dir) =>
    ref.current.scrollBy({ left: dir * ref.current.clientWidth, behavior: "smooth" });

  const goPage = (i) =>
    ref.current.scrollTo({ left: i * ref.current.clientWidth, behavior: "smooth" });

  return (
    <div className="car">
      <button className="car-arrow left" onClick={() => go(-1)} aria-label="Previous">
        <ChevronLeft size={34} strokeWidth={1.5} />
      </button>

      <div className="car-track" ref={ref} onScroll={measure}>
        {children}
      </div>

      <button className="car-arrow right" onClick={() => go(1)} aria-label="Next">
        <ChevronRight size={34} strokeWidth={1.5} />
      </button>

      {pages > 1 && (
        <div className="dashes">
          {Array.from({ length: pages }).map((_, i) => (
            <button
              key={i}
              className={i === active ? "dash on" : "dash"}
              onClick={() => goPage(i)}
              aria-label={`Page ${i + 1}`}
            />
          ))}
        </div>
      )}
    </div>
  );
}