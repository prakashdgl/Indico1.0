// This file is generated by CodeSmith. Do not edit. All edits to this file will be lost. 
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Dynamic;
using System.Linq.Expressions;
using System.Reflection;
using System.Xml.Serialization;

using Indico.DAL;

//namespace Indico.BusinessObjects
namespace Indico.BusinessObjects
{
    /// <summary>
    /// 
    /// </summary>
    public partial class PackingListSizeQtyBO : BusinessObject, IComparable
    {
        #region fields
        #region Scalar Fields
        private int id;
        private int _packingList;
        private int _qty;
        private int _size;
        #endregion
        
        #region Foreign Key fields
        [NonSerialized][XmlIgnoreAttribute]
        private Indico.BusinessObjects.PackingListBO _objPackingList;
        [NonSerialized][XmlIgnoreAttribute]
        private Indico.BusinessObjects.SizeBO _objSize;
        #endregion
        
        #region Foreign Table Foreign Key fields
        #endregion
        
        #region Other fields
        
        private Indico.DAL.PackingListSizeQty _objDAL = null;
        private bool _doNotUpdateDALObject = false;
        
        #endregion
        
        #endregion
        
        #region Properties
        /// <summary>The Primary Key for this object</summary>
        public int ID
        {   get {return id;}
            set 
            {
                OnIDChanging(value);
                id = value;
                OnIDChanged();
            }
        }
        
        /// <summary>Packing List id.</summary>
        public int PackingList
        {   
            get {return _packingList;}
            set 
            {
                OnPackingListChanging(value);
                _packingList = value;
                if (!this._doNotUpdateDALObject && this._context != null && this.ObjDAL != null && ((int)value != 0))
                {
                    this.ObjDAL.PackingList = (from o in this._context.Context.PackingList
                                           where o.ID == (int)value
                                           select o).ToList<Indico.DAL.PackingList>()[0];
                }
                else if (!this._doNotUpdateDALObject && this._context != null && this.ObjDAL != null && (int)value == 0)
                    this.ObjDAL.PackingList = null;
                OnPackingListChanged();
            }
        }
        /// <summary>Quantity of the packing list.</summary>
        public int Qty
        {   
            get {return _qty;}
            set 
            {
                OnQtyChanging(value);
                _qty = value;
                if (!this._doNotUpdateDALObject && this.Context != null && this.ObjDAL != null){
                    this.ObjDAL.Qty = value;
                }
                OnQtyChanged();
            }
        }
        /// <summary>Size of the packing list.</summary>
        public int Size
        {   
            get {return _size;}
            set 
            {
                OnSizeChanging(value);
                _size = value;
                if (!this._doNotUpdateDALObject && this._context != null && this.ObjDAL != null && ((int)value != 0))
                {
                    this.ObjDAL.Size = (from o in this._context.Context.Size
                                           where o.ID == (int)value
                                           select o).ToList<Indico.DAL.Size>()[0];
                }
                else if (!this._doNotUpdateDALObject && this._context != null && this.ObjDAL != null && (int)value == 0)
                    this.ObjDAL.Size = null;
                OnSizeChanged();
            }
        }
        
        internal Indico.DAL.PackingListSizeQty ObjDAL
        {
            get 
            {
                if (_objDAL == null && base._createDAL)
                {
                    _objDAL = this.SetDAL(this.Context.Context);
                    this.ObjDAL.PropertyChanged += new System.ComponentModel.PropertyChangedEventHandler(obj_PropertyChanged);
                }

                return _objDAL;
            }
            set 
            {
                _objDAL = value;
            }
        }
        
        #endregion
        
        #region Non-scalar Properties
        
        #region Foreign Key Objects
        ///<summary>The PackingListBO object identified by the value of PackingList</summary>
        [XmlIgnoreAttribute]
        public Indico.BusinessObjects.PackingListBO objPackingList
        {
            get
            {
                if ( _packingList > 0 && _objPackingList == null)
                {
                        if (this._context == null)
                        {
                            _objPackingList = new Indico.BusinessObjects.PackingListBO();
                        }
                        else
                        {
                            _objPackingList = new Indico.BusinessObjects.PackingListBO(ref this._context);
                        }
                        _objPackingList.ID = _packingList;
                        _objPackingList.GetObject(); 
                }
                return _objPackingList;
            }
            set
            { 
                _objPackingList = value;
                _packingList = _objPackingList.ID;
            }
        }
        ///<summary>The SizeBO object identified by the value of Size</summary>
        [XmlIgnoreAttribute]
        public Indico.BusinessObjects.SizeBO objSize
        {
            get
            {
                if ( _size > 0 && _objSize == null)
                {
                        if (this._context == null)
                        {
                            _objSize = new Indico.BusinessObjects.SizeBO();
                        }
                        else
                        {
                            _objSize = new Indico.BusinessObjects.SizeBO(ref this._context);
                        }
                        _objSize.ID = _size;
                        _objSize.GetObject(); 
                }
                return _objSize;
            }
            set
            { 
                _objSize = value;
                _size = _objSize.ID;
            }
        }
        #endregion
        
        #region Foreign Object Foreign Key Collections
        #endregion
        
        #endregion
        
        #region Internal Constructors
        /// <summary>
        /// Creates an instance of the PackingListSizeQtyBO class using the supplied Indico.DAL.PackingListSizeQty. 
        /// </summary>
        /// <param name="obj">a Indico.DAL.PackingListSizeQty whose properties will be used to initialise the PackingListSizeQtyBO</param>
        internal PackingListSizeQtyBO(Indico.DAL.PackingListSizeQty obj, ref IndicoContext context)
        {
            this._doNotUpdateDALObject = true;
            
            this.Context = context;
        
            // set the properties from the Indico.DAL.PackingListSizeQty 
            this.ID = obj.ID;
            
            this.PackingList = (obj.PackingListReference.EntityKey != null && obj.PackingListReference.EntityKey.EntityKeyValues.Count() > 0)
                ? (int)((System.Data.EntityKeyMember)obj.PackingListReference.EntityKey.EntityKeyValues.GetValue(0)).Value
                : 0;
            this.Qty = obj.Qty;
            this.Size = (obj.SizeReference.EntityKey != null && obj.SizeReference.EntityKey.EntityKeyValues.Count() > 0)
                ? (int)((System.Data.EntityKeyMember)obj.SizeReference.EntityKey.EntityKeyValues.GetValue(0)).Value
                : 0;
            
            this._doNotUpdateDALObject = false;
        }
        #endregion
        
        #region Internal utility methods
        internal Indico.DAL.PackingListSizeQty SetDAL(IndicoEntities context)
        {
            this._doNotUpdateDALObject = true;
        
            // set the Indico.DAL.PackingListSizeQty properties
            Indico.DAL.PackingListSizeQty obj = new Indico.DAL.PackingListSizeQty();
            
            if (this.ID > 0)
            {
                obj = context.PackingListSizeQty.FirstOrDefault<PackingListSizeQty>(o => o.ID == this.ID);
            }
            
            obj.Qty = this.Qty;
            
            if (this.PackingList > 0) obj.PackingList = context.PackingList.FirstOrDefault(o => o.ID == this.PackingList);
            if (this.Size > 0) obj.Size = context.Size.FirstOrDefault(o => o.ID == this.Size);
            
            
            this._doNotUpdateDALObject = false;
            
            return obj;
        }
        
        internal void SetBO(System.Data.Objects.DataClasses.EntityObject eObj)
        {
            this._doNotUpdateDALObject = true;
            
            // Check the received type
            if (eObj.GetType() != typeof(Indico.DAL.PackingListSizeQty))
            {
                throw new FormatException("Received wrong parameter type...");
            }

            Indico.DAL.PackingListSizeQty obj = (Indico.DAL.PackingListSizeQty)eObj;
            
            // set the Indico.BusinessObjects.PackingListSizeQtyBO properties
            this.ID = obj.ID;
            
            this.Qty = obj.Qty;
            
            this.PackingList = (obj.PackingListReference.EntityKey != null && obj.PackingListReference.EntityKey.EntityKeyValues.Count() > 0)
                ? (int)((System.Data.EntityKeyMember)obj.PackingListReference.EntityKey.EntityKeyValues.GetValue(0)).Value
                : 0;
            this.Size = (obj.SizeReference.EntityKey != null && obj.SizeReference.EntityKey.EntityKeyValues.Count() > 0)
                ? (int)((System.Data.EntityKeyMember)obj.SizeReference.EntityKey.EntityKeyValues.GetValue(0)).Value
                : 0;
            
            this._doNotUpdateDALObject = false;
        }
        
        internal void SetBO(Indico.BusinessObjects.PackingListSizeQtyBO obj)
        {
            this._doNotUpdateDALObject = true;
            
            // set this Indico.BusinessObjects.PackingListSizeQtyBO properties
            this.ID = obj.ID;
            
            this.PackingList = obj.PackingList;
            this.Qty = obj.Qty;
            this.Size = obj.Size;
            
            this._doNotUpdateDALObject = false;
        }
        
        internal List<Indico.BusinessObjects.PackingListSizeQtyBO> IQueryableToList(IQueryable<Indico.DAL.PackingListSizeQty> oQuery)
        {
            List<Indico.DAL.PackingListSizeQty> oList = oQuery.ToList();
            List<Indico.BusinessObjects.PackingListSizeQtyBO> rList = new List<Indico.BusinessObjects.PackingListSizeQtyBO>(oList.Count);
            foreach (Indico.DAL.PackingListSizeQty o in oList)
            {
                Indico.BusinessObjects.PackingListSizeQtyBO obj = new Indico.BusinessObjects.PackingListSizeQtyBO(o, ref this._context);
                rList.Add(obj);
            }
            return rList;
        }
        
        internal List<Indico.BusinessObjects.PackingListSizeQtyBO> ToList(IEnumerable<Indico.DAL.PackingListSizeQty> oQuery)
        {
            List<Indico.DAL.PackingListSizeQty> oList = oQuery.ToList();
            List<Indico.BusinessObjects.PackingListSizeQtyBO> rList = new List<Indico.BusinessObjects.PackingListSizeQtyBO>(oList.Count);
            foreach (Indico.DAL.PackingListSizeQty o in oList)
            {
                Indico.BusinessObjects.PackingListSizeQtyBO obj = new Indico.BusinessObjects.PackingListSizeQtyBO(o, ref this._context);
                rList.Add(obj);
            }
            return rList;
        }
        
        internal static List<Indico.DAL.PackingListSizeQty> ToEntityList(List<PackingListSizeQtyBO> bos, IndicoEntities context)
        {
            // build a List of PackingListSizeQty entities from the business objects
            List<Int32> ids = (from o in bos
                                   select o.ID).ToList<Int32>();

            return (context.PackingListSizeQty.Count() == 0) ? new List<Indico.DAL.PackingListSizeQty>() : (context.PackingListSizeQty.Where(BuildContainsExpression<PackingListSizeQty, int>(e => e.ID, ids)))
                .ToList<Indico.DAL.PackingListSizeQty>();
        }
        
        internal static System.Data.Objects.DataClasses.EntityCollection<Indico.DAL.PackingListSizeQty> ToEntityCollection(List<PackingListSizeQtyBO> bos, IndicoEntities context)
        {
            // build an EntityCollection of PackingListSizeQty entities from the business objects
            List<Int32> ids = (from o in bos
                               select o.ID).ToList<Int32>();

            List<Indico.DAL.PackingListSizeQty> el = (context.PackingListSizeQty.Count() == 0) ? new List<Indico.DAL.PackingListSizeQty>() : 
                context.PackingListSizeQty.Where(BuildContainsExpression<PackingListSizeQty, int>(e => e.ID, ids))
                .ToList<Indico.DAL.PackingListSizeQty>();
                
            System.Data.Objects.DataClasses.EntityCollection<Indico.DAL.PackingListSizeQty> ec 
                = new System.Data.Objects.DataClasses.EntityCollection<Indico.DAL.PackingListSizeQty>();
                
            foreach (Indico.DAL.PackingListSizeQty r in el) 
            {
                ec.Add(r);
            }
            return ec;
        }

        internal Indico.DAL.PackingListSizeQty ToEntity(IndicoEntities context)
        {
            return (from o in context.PackingListSizeQty
                    where o.ID == this.ID
                    select o).FirstOrDefault();
        }
        #endregion
        
        #region BusinessObject methods
        
        #region Add Object
        
        public void Add()
        {
            if (this.Context != null)
            {
                this.Context.Context.AddToPackingListSizeQty(this.ObjDAL);
            }
            else
            {
                IndicoContext objContext = new IndicoContext();
                Indico.DAL.PackingListSizeQty obj = this.SetDAL(objContext.Context);
                objContext.Context.AddToPackingListSizeQty(obj);
                objContext.SaveChanges();
                objContext.Dispose(); 
            }
        }
        
        #endregion
        
        #region Delete Object
        
        public void Delete()
        {
            if (this.Context != null)
            {
                if (this.ObjDAL != null && this.ObjDAL.EntityKey != null)
                {
                    if (this.ObjDAL.EntityState == System.Data.EntityState.Detached)
                    {
                        this.Context.Context.Attach(this.ObjDAL);
                        this.Context.Context.DeleteObject(this.ObjDAL);
                    }
                    else
                    {
                        this.Context.Context.DeleteObject(this.ObjDAL);
                    }
                }
                else
                {
                    Indico.DAL.PackingListSizeQty obj = this.SetDAL(this.Context.Context);
                    this.Context.Context.DeleteObject(obj);
                }
            }
            else
            {
                IndicoContext objContext = new IndicoContext();
                Indico.DAL.PackingListSizeQty obj = this.SetDAL(objContext.Context);
                this.Context.Context.DeleteObject(obj);
                objContext.Context.SaveChanges();
                objContext.Dispose();
            }
        }
        
        #endregion
        
        #region Get Single Object
        
        public bool GetObject()
        {
            return GetObject(true);
        }
        public bool GetObject(bool blnCache)
        {
            Indico.BusinessObjects.PackingListSizeQtyBO data = null;
            
            if (blnCache)
            {
                data = this.GetFromCache(this.ID) as Indico.BusinessObjects.PackingListSizeQtyBO; 
            }

            if (data != null)
            {
                SetBO(data);
            }
            else
            {
                try
                {
                    IndicoEntities context = (this.Context != null) ? this.Context.Context : new IndicoEntities();
                    IQueryable<Indico.DAL.PackingListSizeQty> oQuery =
                        from o in context.PackingListSizeQty
                        where o.ID == this.ID
                        select o;

                    List<Indico.DAL.PackingListSizeQty> oList = oQuery.ToList();
                    if (oList.Count != 1)
                        return false;
                    else
                    {
                        SetBO(oList[0]);
                        this.Cache();
                    }
                    
                    if (this.Context == null)
                    {
                        context.Dispose();
                    }
                }
                catch (System.Exception e)
                {
                    throw new IndicoException(String.Format(System.Globalization.CultureInfo.InvariantCulture, ResourceManager.GetString("Could not Retrieve a {0} from the data store", System.Globalization.CultureInfo.CurrentCulture), this.ToString()), e, IndicoException.Severities.USER, IndicoException.ERRNO.INT_ERR_BO_SELECT_FAIL);
                }
            }
            return true;
        }
        #endregion
        
        #region GetAllObject
        public List<Indico.BusinessObjects.PackingListSizeQtyBO> GetAllObject()
        {
            return GetAllObject(0, 0);
        }
        public List<Indico.BusinessObjects.PackingListSizeQtyBO> GetAllObject(int maximumRows)
        {
            return GetAllObject(maximumRows, 0);
        }
        public List<Indico.BusinessObjects.PackingListSizeQtyBO> GetAllObject(int maximumRows, int startIndex)
        {
            return GetAllObject(maximumRows, startIndex, null, false);
        }
        public List<Indico.BusinessObjects.PackingListSizeQtyBO> GetAllObject(int maximumRows, int startIndex, string sortExpression, bool sortDescending)
        {
            IndicoEntities context = new IndicoEntities();
            IQueryable<Indico.DAL.PackingListSizeQty> oQuery =
                (from o in context.PackingListSizeQty
                 orderby o.ID
                 select o);

            if (sortExpression != null && sortExpression.Length > 0)
            {
                // using System.Linq.Dynamic here in Dynamic.cs;
                if (sortDescending)
                    oQuery = oQuery.OrderBy(sortExpression + " desc").Skip(startIndex).Take((maximumRows == 0) ? Int32.MaxValue : maximumRows);
                else
                    oQuery = oQuery.OrderBy(sortExpression + " asc").Skip(startIndex).Take((maximumRows == 0) ? Int32.MaxValue : maximumRows);
            }
            else
                oQuery = oQuery.OrderBy(obj => obj.ID).Skip(startIndex).Take((maximumRows == 0) ? Int32.MaxValue : maximumRows);

            List<Indico.BusinessObjects.PackingListSizeQtyBO> packinglistsizeqtys = IQueryableToList(oQuery);
            context.Dispose();
            return packinglistsizeqtys;
        }
        #endregion
        
        #region SearchObjects
        public List<Indico.BusinessObjects.PackingListSizeQtyBO> SearchObjects()
        {
            return SearchObjects(0,0);
        }
        public List<Indico.BusinessObjects.PackingListSizeQtyBO> SearchObjects(int maximumRows)
        {
            return SearchObjects(maximumRows, 0);
        }
        public List<Indico.BusinessObjects.PackingListSizeQtyBO> SearchObjects(int maximumRows, int startIndex)
        {
            return SearchObjects(maximumRows, startIndex, null, false);
        }
        public List<Indico.BusinessObjects.PackingListSizeQtyBO> SearchObjects(int maximumRows, int startIndex, string sortExpression, bool sortDescending)
        {
            IndicoEntities context = (this.Context != null) ? this.Context.Context : new IndicoEntities();
            IQueryable<Indico.DAL.PackingListSizeQty> oQuery =
                (from o in context.PackingListSizeQty
                 where
                    (this.ID == 0 || this.ID == o.ID) &&
                    (this.PackingList == 0 || this.PackingList == o.PackingList.ID) &&
                    (this.Size == 0 || this.Size == o.Size.ID) &&
                    (this.Qty == 0 || this.Qty == o.Qty) 
                 orderby o.ID
                 select o);

            if (sortExpression != null && sortExpression.Length > 0)
            {
                // using System.Linq.Dynamic here in Dynamic.cs;
                if (sortDescending)
                    oQuery = oQuery.OrderBy(sortExpression + " desc").Skip(startIndex).Take((maximumRows == 0) ? Int32.MaxValue : maximumRows);
                else
                    oQuery = oQuery.OrderBy(sortExpression + " asc").Skip(startIndex).Take((maximumRows == 0) ? Int32.MaxValue : maximumRows);
            }
            else
                oQuery = oQuery.OrderBy(obj => obj.ID).Skip(startIndex).Take((maximumRows == 0) ? Int32.MaxValue : maximumRows);

            List<Indico.BusinessObjects.PackingListSizeQtyBO> packinglistsizeqtys = IQueryableToList(oQuery);
            
            if (this.Context == null)
            {
                context.Dispose();
            }
            
            return packinglistsizeqtys;
        }
        
        public int SearchObjectsCount()
        {
            IndicoEntities context = (this.Context != null) ? this.Context.Context : new IndicoEntities();
            return (from o in context.PackingListSizeQty
                 where
                    (this.ID == 0 || this.ID == o.ID) &&
                    (this.PackingList == 0 || this.PackingList == o.PackingList.ID) &&
                    (this.Size == 0 || this.Size == o.Size.ID) &&
                    (this.Qty == 0 || this.Qty == o.Qty) 
                 orderby o.ID
                 select o).Count();
        }
        #endregion
        
        #region SearchObjectsLikeAnd
        public List<Indico.BusinessObjects.PackingListSizeQtyBO> SearchLikeAndObjects()
        {
            return SearchLikeAndObjects(0);
        }
        public List<Indico.BusinessObjects.PackingListSizeQtyBO> SearchLikeAndObjects(int maximumRows)
        {
            return SearchLikeAndObjects(maximumRows, 0);
        }
        public List<Indico.BusinessObjects.PackingListSizeQtyBO> SearchLikeAndObjects(int maximumRows, int startIndex)
        {
            return SearchLikeAndObjects(maximumRows, startIndex, null, false);
        }
        public List<Indico.BusinessObjects.PackingListSizeQtyBO> SearchLikeAndObjects(int maximumRows, int startIndex, string sortExpression, bool sortDescending)
        {
            IndicoEntities context = (this.Context != null) ? this.Context.Context : new IndicoEntities();
            IQueryable<Indico.DAL.PackingListSizeQty> oQuery =
                (from o in context.PackingListSizeQty
                 where
                    (this.ID == 0 || o.ID == this.ID) &&
                    (this.PackingList == 0 || o.PackingList.ID == this.PackingList) &&
                    (this.Size == 0 || o.Size.ID == this.Size) &&
                    (this.Qty == 0 || o.Qty == this.Qty) 
                 orderby o.ID
                 select o);

            if (sortExpression != null && sortExpression.Length > 0)
            {
                // using System.Linq.Dynamic here in Dynamic.cs;
                if (sortDescending)
                    oQuery = oQuery.OrderBy(sortExpression + " desc").Skip(startIndex).Take((maximumRows == 0) ? Int32.MaxValue : maximumRows);
                else
                    oQuery = oQuery.OrderBy(sortExpression + " asc").Skip(startIndex).Take((maximumRows == 0) ? Int32.MaxValue : maximumRows);
            }
            else
                oQuery = oQuery.OrderBy(obj => obj.ID).Skip(startIndex).Take((maximumRows == 0) ? Int32.MaxValue : maximumRows);

            List<Indico.BusinessObjects.PackingListSizeQtyBO> packinglistsizeqtys = IQueryableToList(oQuery);
            if (this.Context == null)
            {
                context.Dispose();
            }
            
            return packinglistsizeqtys;
        }
        
        public int SearchLikeAndObjectsCount()
        {
            IndicoEntities context = (this.Context != null) ? this.Context.Context : new IndicoEntities();
            return (from o in context.PackingListSizeQty
                 where
                    (this.ID == 0 || o.ID == this.ID) &&
                    (this.PackingList == 0 || o.PackingList.ID == this.PackingList) &&
                    (this.Size == 0 || o.Size.ID == this.Size) &&
                    (this.Qty == 0 || o.Qty == this.Qty) 
                 orderby o.ID
                 select o).Count();
            
        }
        #endregion
        
        #region SearchObjectsLikeOr
        public List<Indico.BusinessObjects.PackingListSizeQtyBO> SearchLikeOrObjects()
        {
            return SearchLikeOrObjects(0);
        }
        public List<Indico.BusinessObjects.PackingListSizeQtyBO> SearchLikeOrObjects(int maximumRows)
        {
            return SearchLikeOrObjects(maximumRows, 0);
        }
        public List<Indico.BusinessObjects.PackingListSizeQtyBO> SearchLikeOrObjects(int maximumRows, int startIndex)
        {
            return SearchLikeOrObjects(maximumRows, startIndex, null, false);
        }
        public List<Indico.BusinessObjects.PackingListSizeQtyBO> SearchLikeOrObjects(int maximumRows, int startIndex, string sortExpression, bool sortDescending)
        {
            IndicoEntities context = (this.Context != null) ? this.Context.Context : new IndicoEntities();
            IQueryable<Indico.DAL.PackingListSizeQty> oQuery =
                (from o in context.PackingListSizeQty
                 where
                    (this.ID == 0 || this.ID == o.ID) && 
                    (this.PackingList == 0 || this.PackingList == o.PackingList.ID) && 
                    (this.Size == 0 || this.Size == o.Size.ID) && 
                    (this.Qty == 0 || this.Qty == o.Qty) 

                 orderby o.ID
                 select o);

            if (sortExpression != null && sortExpression.Length > 0)
            {
                // using System.Linq.Dynamic here in Dynamic.cs;
                if (sortDescending)
                    oQuery = oQuery.OrderBy(sortExpression + " desc").Skip(startIndex).Take((maximumRows == 0) ? Int32.MaxValue : maximumRows);
                else
                    oQuery = oQuery.OrderBy(sortExpression + " asc").Skip(startIndex).Take((maximumRows == 0) ? Int32.MaxValue : maximumRows);
            }
            else
                oQuery = oQuery.OrderBy(obj => obj.ID).Skip(startIndex).Take((maximumRows == 0) ? Int32.MaxValue : maximumRows);

            List<Indico.BusinessObjects.PackingListSizeQtyBO> packinglistsizeqtys = IQueryableToList(oQuery);
            if (this.Context == null)
            {
                context.Dispose();
            }
            
            return packinglistsizeqtys;
        }
        
        public int SearchLikeOrObjectsCount()
        {
            IndicoEntities context = (this.Context != null) ? this.Context.Context : new IndicoEntities();
            return (from o in context.PackingListSizeQty
                 where
                    (this.ID == 0 || this.ID == o.ID) && 
                    (this.PackingList == 0 || this.PackingList == o.PackingList.ID) && 
                    (this.Size == 0 || this.Size == o.Size.ID) && 
                    (this.Qty == 0 || this.Qty == o.Qty) 

                 orderby o.ID
                 select o).Count();
            
        }
        #endregion
        
        #region Serialization methods
        /// <summary>
        /// Serializes the Indico.BusinessObjects.PackingListSizeQtyBO to an XML representation
        /// </summary>
        /// <returns>a XML string serialized representation</returns>
        public string SerializeObject()
        {
            string strReturn = "";

            System.IO.MemoryStream objStream = new System.IO.MemoryStream();

            System.Xml.Serialization.XmlSerializer x = new System.Xml.Serialization.XmlSerializer(this.GetType());

            x.Serialize(objStream, this);

            System.Text.Encoding encoding = System.Text.Encoding.UTF8;
            // Read string from binary file with UTF8 encoding
            strReturn = encoding.GetString(objStream.GetBuffer());

            objStream.Close();
            return strReturn;

        }

        /// <summary>
        /// Deserializes Indico.BusinessObjects.PackingListSizeQtyBO object from an XML representation
        /// </summary>
        /// <param name="strXML">a XML string serialized representation</param>
        public Indico.BusinessObjects.PackingListSizeQtyBO DeserializeObject(string strXML)
        {
            Indico.BusinessObjects.PackingListSizeQtyBO objTemp = null;
            System.Xml.XmlDocument objXML = new System.Xml.XmlDocument();

            objXML.LoadXml(strXML);
            System.Text.Encoding encoding = System.Text.Encoding.UTF8;

            System.IO.MemoryStream objStream = new System.IO.MemoryStream();
            byte[] b = encoding.GetBytes(objXML.OuterXml);

            objStream.Write(b, 0, (int)b.Length);
            objStream.Position = 0;
            System.Xml.Serialization.XmlSerializer x = new System.Xml.Serialization.XmlSerializer(this.GetType());

            objTemp = (Indico.BusinessObjects.PackingListSizeQtyBO)x.Deserialize(objStream);
            objStream.Close();
            return objTemp;
        }

        /// <summary>
        /// Returns a simple XML representation of Indico.BusinessObjects.PackingListSizeQtyBO object in an XmlElement
        /// </summary>
        /// <returns>An XML snippet representing the object</returns>
        public string ToXmlString()
        {
            // MW TODO - implement this better.
            return SerializeObject();
        }
        #endregion
        
        #region OnPropertyChange Methods
        partial void OnIDChanged()
        {
            OnPackingListSizeQtyBOIDChanged();
        }
        
        partial void OnIDChanging(int value)
        {
            if (value < 0)
            {
                throw new Exception(String.Format("PackingListSizeQtyBO.ID must be more than or equal to 0. The supplied value was {0}.", value));
            }
            OnPackingListSizeQtyBOIDChanging(value);
        }
        partial void OnIDChanged();
        partial void OnIDChanging(int value);
        partial void OnPackingListSizeQtyBOIDChanged();
        partial void OnPackingListSizeQtyBOIDChanging(int value);
        
        partial void OnPackingListChanged()
        {
            OnPackingListSizeQtyBOPackingListChanged();
        }
        
        partial void OnPackingListChanging(int value)
        {
            if (value < 0)
            {
                throw new Exception(String.Format("PackingListSizeQtyBO.PackingList must be more than or equal to 0. The supplied value was {0}.", value));
            }
            OnPackingListSizeQtyBOPackingListChanging(value);
        }
        partial void OnPackingListChanged();
        partial void OnPackingListChanging(int value);
        partial void OnPackingListSizeQtyBOPackingListChanged();
        partial void OnPackingListSizeQtyBOPackingListChanging(int value);
        
        partial void OnSizeChanged()
        {
            OnPackingListSizeQtyBOSizeChanged();
        }
        
        partial void OnSizeChanging(int value)
        {
            if (value < 0)
            {
                throw new Exception(String.Format("PackingListSizeQtyBO.Size must be more than or equal to 0. The supplied value was {0}.", value));
            }
            OnPackingListSizeQtyBOSizeChanging(value);
        }
        partial void OnSizeChanged();
        partial void OnSizeChanging(int value);
        partial void OnPackingListSizeQtyBOSizeChanged();
        partial void OnPackingListSizeQtyBOSizeChanging(int value);
        
        partial void OnQtyChanged()
        {
            OnPackingListSizeQtyBOQtyChanged();
        }
        
        partial void OnQtyChanging(int value)
        {
            OnPackingListSizeQtyBOQtyChanging(value);
        }
        partial void OnQtyChanged();
        partial void OnQtyChanging(int value);
        partial void OnPackingListSizeQtyBOQtyChanged();
        partial void OnPackingListSizeQtyBOQtyChanging(int value);
        
        #endregion
        
        #region IComparable Members

        public int CompareTo(object obj)
        {
            if (!(obj is Indico.BusinessObjects.PackingListSizeQtyBO))
                return 1;
            Indico.BusinessObjects.PackingListSizeQtyBOComparer c = new Indico.BusinessObjects.PackingListSizeQtyBOComparer();
            return c.Compare(this, obj as Indico.BusinessObjects.PackingListSizeQtyBO);
        }

        #endregion
        #endregion
        
        #region Events
        
        void obj_PropertyChanged(object sender, System.ComponentModel.PropertyChangedEventArgs e)
        {
            if (e.PropertyName == "ID")
            {
                // reload me
                this.SetBO((Indico.DAL.PackingListSizeQty)sender);
            }
        }
        
        void Context_OnSendBeforeChanges(object sender, EventArgs e)
        {        
        }
        
        void Context_OnSendAfterChanges(object sender, EventArgs e)
        {   
            if (this.ID > 0)
            {
                this.Cache();
            }
        }

        #endregion
    }
    
    #region PackingListSizeQtyBOComparer
    public class PackingListSizeQtyBOComparer : IComparer<Indico.BusinessObjects.PackingListSizeQtyBO>
    {
        private string propertyToCompareName;
        public PackingListSizeQtyBOComparer(string propertyToCompare)
        {
            PropertyInfo p = typeof(Indico.BusinessObjects.PackingListSizeQtyBO).GetProperty(propertyToCompare);
            if (p == null)
                throw new ArgumentException("is not a public property of Indico.BusinessObjects.PackingListSizeQtyBO", "propertyToCompare");
            this.propertyToCompareName = propertyToCompare;
        }
        
        public PackingListSizeQtyBOComparer()
        {
        
        }

        #region IComparer<Indico.BusinessObjects.PackingListSizeQtyBO> Members
        public int Compare(Indico.BusinessObjects.PackingListSizeQtyBO x, Indico.BusinessObjects.PackingListSizeQtyBO y)
        {
            if (propertyToCompareName != null)
            {
                PropertyInfo p = typeof(Indico.BusinessObjects.PackingListSizeQtyBO).GetProperty(propertyToCompareName);
                return compare(p, x, y);
            }
            else
            {
                PropertyInfo[] arrP = typeof(Indico.BusinessObjects.PackingListSizeQtyBO).GetProperties();
                foreach (PropertyInfo p in arrP)
                {
                    int v = compare(p, x, y);
                    if (v != 0)
                        return v;
                }
                return 0;
            }
        }

        private int compare(PropertyInfo p, Indico.BusinessObjects.PackingListSizeQtyBO x, Indico.BusinessObjects.PackingListSizeQtyBO y)
        {
            object xVal = p.GetValue(x, null);
            object yVal = p.GetValue(y, null);

            if (xVal == null)
            {
                if (yVal == null)
                    return 0;
                else
                    return -1; // x is null, y is not, y is greater
            }
            else
            {
                if (y == null)
                    return 1; // x non null, y is null, x is greater
                else if (xVal is string)
                {
                    return StringComparer.OrdinalIgnoreCase.Compare(xVal, yVal);
                }
                else if (xVal is IComparable)
                {
                    return ((IComparable)xVal).CompareTo((IComparable)yVal);
                }
                else
                    throw new ArgumentException
                        ("is not string or valuetype that implements IComparable", "propertyToCompare");

            }
        }

        #endregion
    }
    #endregion
}
