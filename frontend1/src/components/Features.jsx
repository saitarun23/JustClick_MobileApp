import { Truck, Leaf, ShieldCheck, Clock } from "lucide-react";

const features = [
  { icon: Truck, title: "Fast Delivery", text: "Across India" },
  { icon: Leaf, title: "100% Natural", text: "No preservatives" },
  { icon: ShieldCheck, title: "Secure Payment", text: "Safe checkout" },
  { icon: Clock, title: "Made Fresh", text: "Small batches" },
];

export default function Features() {
  return (
    <section className="features container">
      {features.map(({ icon: Icon, title, text }) => (
        <div className="feature" key={title}>
          <Icon size={30} />
          <div>
            <h4>{title}</h4>
            <p>{text}</p>
          </div>
        </div>
      ))}
    </section>
  );
}