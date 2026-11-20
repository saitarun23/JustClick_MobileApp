import React from 'react';
import {
  DeliveryPartnerIllustration,
  FarmTruckIllustration,
  HarvestStepIllustration,
  PackingStepIllustration,
} from './Illustrations';

export default function HowItWorks() {
  return (
    <section id="how-it-works" className="how-section">
      <div className="container">
        <div className="section-heading">
          <span className="eyebrow-tag">FARM TO DOORSTEP</span>
          <h2>How Farm2Bay Works</h2>
          <p>
            From morning harvest at partner farms to eco-friendly delivery across the city—every
            item travels directly with zero middlemen.
          </p>
        </div>

        <div className="steps-grid">
          <article className="step-card">
            <span className="step-num">01</span>
            <HarvestStepIllustration />
            <h3>Morning Farm Harvest</h3>
            <p>
              Fresh A2 milk is bottled at dawn, vegetables are hand-picked, and pickles & spice
              powders are prepared in small batches.
            </p>
          </article>

          <article className="step-card">
            <span className="step-num">02</span>
            <PackingStepIllustration />
            <h3>Packed in Wooden Crates & Jars</h3>
            <p>
              We pack dairy and pickles in reusable glass jars and bundle fresh produce in
              breathable farmer&apos;s market crates.
            </p>
          </article>

          <article className="step-card step-card-featured">
            <span className="step-num">03</span>
            <FarmTruckIllustration className="step-truck-mini" />
            <h3>Farm-to-City Express Truck</h3>
            <p>
              Our daily Farm2Bay pickup trucks transport your order straight from rural farms to
              neighborhood city hubs.
            </p>
          </article>

          <article className="step-card">
            <span className="step-num">04</span>
            <DeliveryPartnerIllustration />
            <h3>Delivered to Your Door</h3>
            <p>
              Our local riders bring your wooden crate or paper grocery bag right to your doorstep
              while everything is still crisp.
            </p>
          </article>
        </div>
      </div>
    </section>
  );
}