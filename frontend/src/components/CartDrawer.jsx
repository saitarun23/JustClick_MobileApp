import React from 'react';
import { X, ShoppingBag, Plus, Minus, ArrowRight } from 'lucide-react';

export default function CartDrawer({ 
  isOpen, 
  onClose, 
  cart, 
  updateQuantity, 
  subtotal, 
  freeShippingTarget, 
  onCheckout 
}) {
  if (!isOpen) return null;

  return (
    <div className="fixed inset-0 z-50 bg-slate-900/40 backdrop-blur-sm flex justify-end">
      <div className="bg-white w-full max-w-md h-full flex flex-col justify-between p-6 shadow-2xl relative animate-in slide-in-from-right duration-300">
        
        {/* Header */}
        <div className="flex items-center justify-between border-b border-slate-100 pb-4">
          <div className="flex items-center gap-2">
            <ShoppingBag className="w-5 h-5 text-emerald-600" />
            <h3 className="font-extrabold text-lg text-slate-900">Your Delivery Bag</h3>
          </div>
          <button onClick={onClose} className="p-2 text-slate-400 hover:text-slate-600 rounded-full hover:bg-slate-100">
            <X className="w-5 h-5" />
          </button>
        </div>

        {/* Free Shipping Progress */}
        <div className="my-4 bg-emerald-50 p-3.5 rounded-xl border border-emerald-100">
          <div className="flex items-center justify-between text-xs font-bold text-emerald-950 mb-1.5">
            <span>
              {subtotal >= freeShippingTarget 
                ? '🎉 Free Delivery Unlocked!' 
                : `Add ₹${(freeShippingTarget - subtotal).toFixed(2)} more for Free Express Shipping`}
            </span>
          </div>
          <div className="w-full h-2 bg-emerald-200/60 rounded-full overflow-hidden">
            <div 
              className="h-full bg-emerald-600 rounded-full transition-all duration-300"
              style={{ width: `${Math.min(100, (subtotal / freeShippingTarget) * 100)}%` }}
            />
          </div>
        </div>

        {/* Items List */}
        <div className="flex-1 overflow-y-auto space-y-3 pr-1">
          {cart.length === 0 ? (
            <div className="text-center py-16">
              <ShoppingBag className="w-12 h-12 text-slate-200 mx-auto mb-3" />
              <p className="text-sm font-bold text-slate-400">Your bag is empty</p>
            </div>
          ) : (
            cart.map((item) => (
              <div key={item.id} className="flex items-center gap-3 p-3 rounded-xl border border-slate-100 hover:border-slate-200">
                <img src={item.image} alt={item.name} className="w-14 h-14 rounded-lg object-cover bg-slate-50" />
                <div className="flex-1">
                  <h4 className="font-bold text-xs text-slate-900 line-clamp-1">{item.name}</h4>
                  <div className="text-xs text-slate-400">{item.unit}</div>
                  <div className="font-extrabold text-sm text-emerald-950 mt-1">₹{(item.price * item.quantity).toFixed(2)}</div>
                </div>
                <div className="flex items-center gap-2 bg-slate-100 rounded-lg p-1">
                  <button onClick={() => updateQuantity(item.id, -1)} className="w-6 h-6 bg-white rounded flex items-center justify-center text-slate-700 shadow-sm">
                    <Minus className="w-3 h-3" />
                  </button>
                  <span className="font-bold text-xs px-1">{item.quantity}</span>
                  <button onClick={() => updateQuantity(item.id, 1)} className="w-6 h-6 bg-emerald-600 text-white rounded flex items-center justify-center shadow-sm">
                    <Plus className="w-3 h-3" />
                  </button>
                </div>
              </div>
            ))
          )}
        </div>

        {/* Footer Checkout */}
        {cart.length > 0 && (
          <div className="border-t border-slate-100 pt-4 space-y-3">
            <div className="space-y-1.5 text-xs text-slate-600">
              <div className="flex justify-between">
                <span>Subtotal</span>
                <span className="font-bold text-slate-900">₹{subtotal.toFixed(2)}</span>
              </div>
              <div className="flex justify-between">
                <span>Delivery Fee</span>
                <span className="font-bold text-emerald-700">
                  {subtotal >= freeShippingTarget ? 'FREE' : '₹1.99'}
                </span>
              </div>
              <div className="flex justify-between text-sm font-extrabold text-slate-900 pt-2 border-t border-slate-100">
                <span>Total Amount</span>
                <span className="text-emerald-950">
                  ₹{(subtotal + (subtotal >= freeShippingTarget ? 0 : 1.99)).toFixed(2)}
                </span>
              </div>
            </div>

            <button 
              onClick={onCheckout}
              className="w-full bg-emerald-600 hover:bg-emerald-700 text-white py-3.5 rounded-xl font-bold text-sm shadow-lg shadow-emerald-600/30 flex items-center justify-center gap-2"
            >
              <span>Proceed to Express Checkout</span>
              <ArrowRight className="w-4 h-4" />
            </button>
          </div>
        )}
      </div>
    </div>
  );
}