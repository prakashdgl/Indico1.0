//------------------------------------------------------------------------------
// <auto-generated>
//    This code was generated from a template.
//
//    Manual changes to this file may cause unexpected behavior in your application.
//    Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Indico.Model
{
    using System;
    using System.Collections.Generic;
    
    public partial class DistributorPatternPriceLevelCostView
    {
        public int ID { get; set; }
        public int Price { get; set; }
        public int PriceLevel { get; set; }
        public decimal FactoryCost { get; set; }
        public decimal IndimanCost { get; set; }
        public Nullable<int> Distributor { get; set; }
        public decimal Markup { get; set; }
        public Nullable<decimal> EditedCIFPrice { get; set; }
        public Nullable<decimal> EditedFOBPrice { get; set; }
        public string ModifiedDate { get; set; }
    }
}
