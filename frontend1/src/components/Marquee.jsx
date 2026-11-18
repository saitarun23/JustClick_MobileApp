import { Sparkles } from "lucide-react";

const items = ["Farm Fresh", "No Preservatives", "Made In Small Batches", "Delivered Across India"];

export default function Marquee() {
  const row = [...items, ...items, ...items, ...items];
  return (
    <div className="marquee">
      <div className="track">
        {row.map((t, i) => (
          <span key={i}>
            {t} <Sparkles size={14} />
          </span>
        ))}
      </div>
    </div>
  );
}