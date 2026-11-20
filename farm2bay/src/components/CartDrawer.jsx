import React, { useState } from 'react';
import { CheckBadgeIcon, FarmTruckIllustration } from './Illustrations';

export default function CartDrawer({
  isOpen,
  onClose,
  cartItems,
  onUpdateQty,
  onClearCart,
}) {
  const [orderPlaced, setOrderPlaced] = useState(false);

  if (!isOpen) return null;

  const subtotal = cartItems.reduce((sum, item) => sum + item.price * item.qty, 0);
  const freeDeliveryThreshold = 499;
  const remainingForFree = Math.max(0, freeDeliveryThreshold - subtotal);
  const deliveryFee = subtotal === 0 || subtotal >= freeDeliveryThreshold ? 0 : 35;

  const handleCheckout = () => {
    setOrderPlaced(true);
    setTimeout(() => {
      onClearCart();
      setOrderPlaced(false);
      onClose();
    }, 2400);
  };

  return (
    <div className="drawer-backdrop" onClick={onClose}>
      <aside className="cart-drawer" onClick={(e) => e.stopPropagation()}>
        <div className="drawer-header">
          <div>
            <h3>Your Farm2Bay Basket</h3>
            <p className="drawer-sub">Direct farm dispatch in eco crates & glass jars</p>
          </div>
          <button type="button" className="icon-close-btn" onClick={onClose} aria-label="Close">
            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.6" strokeLinecap="round">
              <line x1="18" y1="6" x2="6" y2="18" />
              <line x1="6" y1="6" x2="18" y2="18" />
            </svg>
          </button>
        </div>

        <div className="delivery-meter">
          <div className="meter-label-row">
            {remainingForFree === 0 ? (
              <span className="meter-unlocked">
                <CheckBadgeIcon size={16} />
                Free Farm-to-City Truck Delivery unlocked
              </span>
            ) : (
              <span>
                Add <strong>₹{remainingForFree}</strong> more for free city delivery
              </span>
            )}
          </div>
          <div className="meter-bar">
            <div
              className="meter-fill"
              style={{
                width: `${Math.min(100, (subtotal / freeDeliveryThreshold) * 100)}%`,
              }}
            />
          </div>
        </div>

        {orderPlaced ? (
          <div className="order-success-box">
            <FarmTruckIllustration className="success-truck-svg" />
            <h4>Order Dispatched to Farm</h4>
            <p>
              Our Farm2Bay truck will load your fresh basket for the next city delivery slot.
            </p>
          </div>
        ) : cartItems.length === 0 ? (
          <div className="empty-cart-box">
            <p>Your harvest basket is empty.</p>
            <button type="button" className="primary-btn" onClick={onClose}>
              Browse Fresh Products
            </button>
          </div>
        ) : (
          <>
            <div className="cart-items-list">
              {cartItems.map((item) => (
                <div key={item.id} className="cart-item-row">
                  <div className="cart-item-info">
                    <span className="cart-item-cat">{item.categoryLabel}</span>
                    <h4>{item.name}</h4>
                    <small>
                      {item.unit} • ₹{item.price}
                    </small>
                  </div>

                  <div className="qty-stepper">
                    <button type="button" onClick={() => onUpdateQty(item.id, item.qty - 1)}>
                      −
                    </button>
                    <span>{item.qty}</span>
                    <button type="button" onClick={() => onUpdateQty(item.id, item.qty + 1)}>
                      +
                    </button>
                  </div>
                </div>
              ))}
            </div>

            <div className="drawer-footer">
              <div className="bill-row">
                <span>Harvest Subtotal</span>
                <span>₹{subtotal}</span>
              </div>
              <div className="bill-row">
                <span>Farm-to-City Delivery</span>
                <span>{deliveryFee === 0 ? 'FREE' : `₹${deliveryFee}`}</span>
              </div>
              <div className="bill-row bill-total">
                <span>Total Payable</span>
                <span>₹{subtotal + deliveryFee}</span>
              </div>
              <button type="button" className="primary-btn checkout-btn" onClick={handleCheckout}>
                Confirm Farm Order • ₹{subtotal + deliveryFee}
              </button>
            </div>
          </>
        )}
      </aside>
    </div>
  );
}