import { ArrowRight } from "lucide-react";

export default function Story() {
  return (
    <section className="section soft">
      <div className="container two-col">
        <div>
          <p className="eyebrow">Our Story</p>
          <h2 className="title left">From our farm to your kitchen</h2>
          <p>
            Just Click started with a simple idea: bring back the taste of traditional village
            food. Our ghee, pickles and powders are made in small batches using time-tested
            recipes and no artificial preservatives.
          </p>
          <button className="btn">
            Know More <ArrowRight size={16} />
          </button>
        </div>
        <img src="https://placehold.co/560x380/f0e4c8/5a3e2b?text=Our+Farm" alt="Our farm" />
      </div>
    </section>
  );
}