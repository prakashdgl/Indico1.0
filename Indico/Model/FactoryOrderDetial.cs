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
    
    public partial class FactoryOrderDetial
    {
        public int ID { get; set; }
        public int OrderDetail { get; set; }
        public int OrderDetailStatus { get; set; }
        public Nullable<int> CompletedQty { get; set; }
        public Nullable<System.DateTime> StartedDate { get; set; }
        public int Size { get; set; }
    
        public virtual OrderDetail OrderDetail1 { get; set; }
        public virtual OrderDetailStatu OrderDetailStatu { get; set; }
        public virtual Size Size1 { get; set; }
    }
}
