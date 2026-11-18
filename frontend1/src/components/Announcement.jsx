import { Truck } from "lucide-react";

export default function Announcement() {
  return (
    <div className="announce">
      <Truck size={16} />
      <span>
        Farm-fresh &amp; homemade, delivered. Get 10% off your first order with <b>CLICK10</b>
      </span>
    </div>
  );
}