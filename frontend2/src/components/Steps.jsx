import { LuMousePointerClick, LuChefHat, LuBike } from "react-icons/lu";
import "../styles/Steps.css";

const STEPS = [
  { icon: LuMousePointerClick, title: "You click", text: "Choose from shops near you and place the order in under a minute." },
  { icon: LuChefHat, title: "They pack", text: "The shop confirms and packs your order while a rider is assigned." },
  { icon: LuBike, title: "We deliver", text: "Follow the rider live until the order is at your door." },
];

export default function Steps() {
  return (
    <section id="how" className="wrap steps-sec">
      <h2 className="h2">Three steps. No waiting around.</h2>
      <ol className="steps">
        {STEPS.map(({ icon: Icon, title, text }, i) => (
          <li key={title}>
            <span className="step-n">{i + 1}</span>
            <Icon className="step-i" />
            <h3>{title}</h3>
            <p>{text}</p>
          </li>
        ))}
      </ol>
    </section>
  );
}